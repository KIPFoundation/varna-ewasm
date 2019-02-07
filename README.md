# Varna API service for KIDE

This is common(C/C++/Rust) compiler microservice for KIDE. It is also a slug builder.

## Running service locally

The app/server can be run from the "app" folder:

```
cd app
node .
```

By default it will run on "0.0.0.0:8083" address. Use `PORT` environment variable to change it.

```
For C address: 0.0.0.0:8083/build/c
For C++ address: 0.0.0.0:8083/build/cpp
For Rust address: 0.0.0.0:8083/build/rs
```

## Dependencies for Varna 
To get all dependencies run `make dependencies`

The running of the service requires clang/llvm for WebAssembly installed on the machine. You can [compile it yourself](https://github.com/yurydelendik/wasmception) or unpack version from the precomp folder (see instructions below). Use `WASMCEPTION` path to provide its location.

Before running it first time, you will need to setup the dependencies:

1. Install clang/llvm for WebAssembly target, by default, the service will look that in the wasmception folder
    a) Build https://github.com/yurydelendik/wasmception
    b) or, unzip one of the `wasmception-...-bin.tag.gz` files
2. If the clang/llvm and system root is not at the `wasmception` folder, use `WASMCEPTION` environment to specify the folder location.

## Change configuration in KIDE

The "clang" endpoint address can be located at the https://github.com/wasdk/WebAssemblyStudio/blob/master/config.json and be changed locally.

## Building and installing the slug

Run `APP=<your-heroku-app> make publish` to fully build and setup slug at your app.
