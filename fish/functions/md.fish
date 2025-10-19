function md
    if test (count $argv) -eq 0
        echo "Usage: md <markdown-file>"
        return 1
    end

    for file in $argv
        if test -f $file
            pandoc $file | lynx -stdin
        else
            echo "md: file '$file' not found"
        end
    end
end
