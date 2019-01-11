# portable-n64-toolchain
A Dockerized N64 toolchain based on modern-n64sdk

NOTE!! I have not got Spicy/Makemask to work yet.  Unfortunately, you still have to run mild and makemask on your rom after the toolchain builds it.  The goal is to completely build your rom with this toolchain, but it just isn't there yet.  This will build all of the objects that your spec uses to build the rom.

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
