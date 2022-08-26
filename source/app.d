module app;

import bindbc.sdl;
import std.stdio: writefln;
import std.string: toStringz;
import std.typecons: tuple;

// constants
enum wWidth = 800;
enum wHeight = 600;
enum wTitle = "D/SDL2 project";

// colors
enum white = tuple(255, 255, 255, 255);
enum black = tuple(0, 0, 0, 255);

void main()
{   
    if(!initSDL_libs())
    {
        writefln("Unable to initialize SDL libraries!");
        return;
    }
    
    // create window and renderer
    enum windowFlags = SDL_WINDOW_RESIZABLE | SDL_WINDOW_ALLOW_HIGHDPI | SDL_WINDOW_SHOWN;
    SDL_Window* windowID = null;
    SDL_Renderer* rendererID = null;
    if(SDL_CreateWindowAndRenderer(wWidth, wHeight, windowFlags, &windowID, &rendererID) != 0) 
    {
        writefln("Failed to create a new SDL window and renderer!");
        return;
    }
    SDL_SetWindowTitle(windowID, wTitle.toStringz);

    // close and destroy the window and the renderer
    scope(exit) 
    {
        SDL_DestroyWindow(windowID);
        SDL_DestroyRenderer(rendererID);
    }

    // print your SDL version
    SDL_version v;
    SDL_GetVersion(&v);
    writefln("Loaded SDL version: %s.%s.%s", v.major, v.minor, v.patch);
    
    bool quit = false;
    while(!quit) 
    {
        // --- POLL EVENTS --- //
        SDL_Event event;
        SDL_PollEvent(&event);
        switch(event.type)
        {
            case SDL_QUIT:
                quit = true;
                break;
            case SDL_KEYDOWN:
                if(event.key.keysym.sym == SDLK_q || event.key.keysym.sym == SDLK_ESCAPE) 
                {
                    quit = true;
                } 
                break;
            default:
                break;
        }

        // --- UPDATE --- //
        // ...

        // --- RENDER --- //
        SDL_SetRenderDrawColor(rendererID, white.expand);
        SDL_RenderClear(rendererID);
        {
            // draw
            // ...
        }
        SDL_RenderPresent(rendererID);
    }
}

/++ 
Dynamically loads and initializes SDL2, SDL_Image, SDL_TTF, SDL_Mixer libraries

Returns: `true` upon sucess
+/
bool initSDL_libs()
{
    // load SDL2
    if(!loadSDL_libs()) 
    {
        writefln("Unable to load the SDL2 library!");
        return false;
    }

    // initialize SDL2
    if(SDL_Init(SDL_INIT_VIDEO) != 0) 
    {
        writefln("Unable to initialize SDL2!");
        return false;
    }
    scope(exit) { SDL_Quit(); }
    
    // initialize SDL_Image
    enum imgFlags = IMG_INIT_PNG | IMG_INIT_JPG;
    if((IMG_Init(imgFlags) & imgFlags) != imgFlags) 
    {
        writefln("Unable to initialize SDL_Image!");
        return false;
    }
    scope(exit) { IMG_Quit(); }

    // initialize SDL_TTF
    if(TTF_Init() != 0)
    {
        writefln("Unable to initialize SDL_TTF!");
        return false;
    }
    scope(exit) { TTF_Quit(); }

    // initialize SDL_Mixer
    enum mixerFlags = MIX_INIT_OGG | MIX_INIT_MP3;
    if((Mix_Init(mixerFlags) & mixerFlags) != mixerFlags)
    {
        writefln("Unable to initialize SDL_Mixer!");
        return false;
    }
    scope(exit) { Mix_Quit(); }
    
    // initialize SDL_Net
    if(SDLNet_Init() != 0)
    {
        writefln("Unable to initialize SDL_Net!");
        return false;
    }

    return true;
}

/++
Dynamically loads SDL2, SDL_Image, SDL_TTF, SDL_Mixer libraries

Returns: `true` upon success
+/
bool loadSDL_libs()
{
    // load SDL2
    auto sdlRet = loadSDL();
    if(sdlRet != sdlSupport)
    {
        writefln(sdlRet == SDLSupport.noLibrary ? "No SDL2 library found!" : "A newer version of SDL2 is needed. Please, upgrade!");
        return false;
    }
    
    // load SDL_Image
    auto imgRet = loadSDLImage();
    if(imgRet != sdlImageSupport)
    {
        writefln(imgRet == SDLImageSupport.noLibrary ? "No SDL_Image library found!" : "A newer version of SDL_Image is needed. Please, upgrade!");
        return false;
    }

    // load SDL_TTF
    auto ttfRet = loadSDLTTF();
    if(ttfRet != sdlTTFSupport)
    {
        writefln(ttfRet == SDLTTFSupport.noLibrary ? "No SDL_TTF library found!" : "A newer version of SDL_TTF is needed. Please, upgrade!");
        return false;
    }

     // load SDL_Mixer
    auto mixerRet = loadSDLMixer();
    if(mixerRet != sdlMixerSupport)
    {
        writefln(mixerRet == SDLMixerSupport.noLibrary ? "No SDL_Mixer library found!" : "A newer version of SDL_Mixer is needed. Please, upgrade!");
        return false;
    }

    // load SDL_Net
    auto netRet = loadSDLNet();
    if(netRet != sdlNetSupport)
    {
        writefln(netRet == SDLNetSupport.noLibrary ? "No SDL_Net library found!" : "A newer version of SDL_Net is needed. Please, upgrade!");
        return false;
    }

    return true;    
}





