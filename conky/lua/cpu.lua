function conky_mycpus()
    local file = io.popen("grep -c processor /proc/cpuinfo")
    local numcpus = file:read("*n")
    file:close()
    listcpus = ""
    for i = 1,numcpus
        do
            if (i > 1) then
                if (i % 2 > 0) then
                    listcpus = listcpus.."\n "
                end
            end
            strI = tostring(i)
            if i < 10 then
                strI = " "..strI
            end
            listcpus = listcpus.."Core "..strI.." ${color yellow}${freq_g "..strI.."} ${color green}${cpubar cpu"..strI.." 6,75}${color grey} "
    end

    return listcpus
end
