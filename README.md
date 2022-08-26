# D/SDL2 project template
D and SDL2 project template with DUB. It contains code for dynamically loading and initialization of `SDL2, SDL_Image, SDL_TTF, SDL_Mixer, SDL_Net` libraries. Check out the `dub.json` and `source/app.d` files for more info.

### Required toolchain
* [D](https://dlang.org/download) compiler
* [DUB](https://dub.pm/) package manager

### Dependencies
D uses the [bindbc-sdl](https://github.com/BindBC/bindbc-sdl) package. It is handled by DUB automatically. 

Please, make sure you have the following libraries installed on your system:
* SDL2
* SDL_Image
* SDL_TTF
* SDL_Mixer
* SDL_Net

If you don't need all of them, then remove those parts of the code from your project. 

Configure your `dub.json`:
```
"dependencies": {
		"bindbc-sdl": "~>1.2.1"
	},
"versions": ["SDL_2020", "SDL_Image", "SDL_TTF", "SDL_Mixer", "SDL_Net"]
```
or `dub.sdl`:
```
dependency "bindbc-sdl" version="~>1.2.1"
versions "SDL_2020" "SDL_Image" "SDL_TTF" "SDL_Mixer" "SDL_Net"
```

### Compiling and running
```
dub
```

### LICENSE
All code is licensed under MIT.

