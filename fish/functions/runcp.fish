function runcp
    if test (count $argv) -eq 0
        echo "Usage: runcp file.cpp"
        return 1
    end

    set file $argv[1]

    if not test -f $file
        echo "File not found: $file"
        return 1
    end

    set name (basename $file .cpp)
    set out /tmp/$name

    echo "Compiling $file..."
    g++ -g "$file" -o "$out"
    or return 1

    echo "Running with clipboard input..."
    
    # Try common clipboard tools
    if type -q wl-paste
        wl-paste | "$out"
    else if type -q xclip
        xclip -selection clipboard -o | "$out"
    else if type -q xsel
        xsel --clipboard --output | "$out"
    else
        echo "No clipboard tool found (install wl-paste, xclip, or xsel)"
        return 1
    end
end
