function zen-fast --description "Launch Zen Browser with Intel VAAPI acceleration"
    # Set Intel VAAPI environment variables
    set -x LIBVA_DRIVER_NAME iHD
    set -x INTEL_MEDIA_RUNTIME 1
    set -x MOZ_X11_EGL 1
    
    # Enable Wayland if available
    if test "$XDG_SESSION_TYPE" = "wayland"
        set -x MOZ_ENABLE_WAYLAND 1
    end
    
    # Additional performance optimizations
    set -x MOZ_WEBRENDER 1
    set -x MOZ_ACCELERATED 1
    
    # Launch zen-browser with optimizations
    echo "🚀 Launching Zen Browser with Intel VAAPI acceleration..."
    zen-browser $argv &
    
    # Clean up environment variables (optional)
    set -e LIBVA_DRIVER_NAME
    set -e INTEL_MEDIA_RUNTIME
    set -e MOZ_X11_EGL
    set -e MOZ_ENABLE_WAYLAND
    set -e MOZ_WEBRENDER
    set -e MOZ_ACCELERATED
end
