#!/usr/bin/env texlua


module = "magicnum"

textfiles = {"README.md"}
unpackfiles = {'magicnum.dtx'}
sourcefiles={"*.dtx"}
installfiles={"*.sty","*.lua","*.txt"}
scriptfiles={"*.lua"}

tdslocations={
"doc/latex/magicnum/magicnum.pdf",
"doc/latex/magicnum/magicnum.txt",
"scripts/magicnum/magicnum.lua",
"source/latex/magicnum/magicnum.dtx",
"tex/generic/magicnum/magicnum.sty"
}
 
packtdszip  = true

maxprintline=10000
checkruns = 2



function update_tag(file,content,tagname,tagdate)

local tagpattern="(%d%d%d%d[-/]%d%d[-/]%d%d) v(%d+[.])(%d+)"
local oldv,newv
if tagname == 'auto' then
  local i,j,olddate,a,b
  i,j,olddate,a,b= string.find(content, tagpattern)
  if i == nil then
    print('OLD TAG NOT FOUND')
    return content
  else
    print ('FOUND: ' .. olddate .. ' v' .. a .. b )
    oldv = olddate .. ' v' .. a .. b
    newv = tagdate .. ' v'  .. a .. math.floor(b + 1)
    print('USING OLD TAG: ' .. oldv)
    print('USING NEW TAG: ' .. newv)
    content=string.gsub(content,"{Version}{" .. oldv,'##OLDV##')
    content=string.gsub(content,string.gsub(oldv,"[-/]", "[-/]"),newv)
    content=string.gsub(content,'##OLDV##',"{Version}{" .. oldv)
    content = string.gsub(content,
        '%% \\end{History}',
	'%%   \\begin{Version}{' .. newv .. '}\n%%   \\item Updated\n%%   \\end{Version}\n%% \\end{History}')
    return content
  end
else
  error("only automatic tagging supported")
end

end


