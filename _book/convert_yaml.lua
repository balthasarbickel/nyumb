function Para(elem)
    if #elem.content == 1 and elem.content[1].t == "Image" then
      local img = elem.content[1]    
      if img.classes:find('markdown',1) then
        local f = io.open(img.src, 'r')
        local doc = pandoc.read(f:read('*a'))
        f:close()

        -- get elements from the metadata
        local title = pandoc.utils.stringify(doc.meta.title) 
        local size = pandoc.utils.stringify(doc.meta.size)
        local time = pandoc.utils.stringify(doc.meta.time)
        local description = pandoc.utils.stringify(doc.meta.description)
        
        -- create latex recipe environment
        table.insert(doc.blocks, 1, pandoc.RawBlock('latex', '\\begin{recipe}{' .. title .. '}' .. '{Für ca. ' .. size .. ' Personen}' .. '{' .. time .. '}')) 
        table.insert(doc.blocks, pandoc.RawBlock('latex', '\\freeform\\hrulefill\\newline\\freeform{'..description..'}\\end{recipe}'))


          -- attempts to insert the sed stuff here, rather than through a pipe in the shell: 
          -- https://www.zeitkraut.com/posts/2017-12-23-extending-pandoc-with-lua.html
          -- pandoc -f markdown -t markdown -i combined.md  -s --lua-filter convert_yaml.lua | sed -e 's/\-.*`\(.*\)` \(.*\)/\\\ingredient{\\1}\\{\\2\\}/g' | pandoc --template=cuisine.latex -o x.pdf 
          -- function Code(el)
          --   table.insert(el.content, pandoc.RawInline('tex', '\\begin{'..el.content))
          -- return
          -- end

        return doc.blocks

      end

    end
end


