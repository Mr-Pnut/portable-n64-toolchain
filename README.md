# portable-n64-toolchain
A Dockerized N64 toolchain based on modern-n64sdk

UPDATE!!
Spicy / Makemask seem to work fine so far.  This toolchain is guaranteed to at least take the nu0 program from source to production rom.

The trick is to pad your rom.  This is because makemask will read bytes 0x1000 - 0x0FF000 of the rom file, which may not exist if the rom is small. You pad the rom with ```spicy -s {mbits}``` I generally just pick the smallest game pak size ```spicy -s 32```.

## Version History
* 1.0.1 (current): Spicy/Makemask added.  Toolchain is precompiled now for faster builds.
* 1.0.0: Initial release

## Huh?
This is a preconfigured, ready to go N64 build environment using the "modern" N64 toolchain found https://github.com/trhodeos/modern-n64sdk (big ups trhodeos).

The goal is minimal setup of the SDK.  This could potentially also make your builds CI ready -- having one central place to build your N64 project team, or getting people set up with an SDK asap, provided they have Docker.

## Building the toolchain
Of course you have to have Docker installed as a prerequisite.  So install it if you don't have it.

1. Clone this repo somewhere.
2. Extract the n64sdk.7z file (with /nintendo and /ultra) to the n64sdk directory of the repo.
3. Run the following, use Powershell if you're on Windows.

```    
> cd $repo
> docker build . -t n64
```

At this point the toolchain will build.  It takes a while, probably 15-20 mins at least.

After that's done you have a Docker image of the toolchain.  You can go to where the soure for your project is at and run the following to build it.

```
> docker run -w /mnt/src -v /where/my/source/is/locally:/mnt/src -it n64 make
```
