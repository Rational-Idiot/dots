function sudo\!\!
    eval (history --max=1 | string replace -r '^' 'sudo ')
end
