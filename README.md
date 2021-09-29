# Docker-Container for ngsolve usage with Jupyter Notebooks

## Installation
Make sure you have [Docker](https://docs.docker.com/get-docker/) installed and follow the instructions for your operating system to have it running.

Then, chose the directory, where you want to have the dockerfile and run

```
git clone https://github.com/aujxn/docker-ngsolve
cd docker-ngsolve
docker build -t ngsolve .
```

Don't forget the `.` at the end of the 3rd line!

Only do this one time per machine or if you change the Dockerfile! This can take a while but Docker caches the build and should be faster after the first time if you need to make changes to the image by editing the Dockerfile.

## Running ngsolve and accessing the server
Now, you need to start the container and both bind the correct ports of the container to the ports of the host and bind your directory with the code you are working on to a directory in the docker-container, i.e.

```
docker run --rm -t -p 8888:8888 -v /path/to/notebooks:/home/jovyan/tmpdir --name ngsolve ngsolve
```

But replace the /path/to/notebooks with the correct path. If you haven't changed directories then:
```
docker run --rm -t -p 8888:8888 -v $(pwd)/notebooks:/home/jovyan/tmpdir --name ngsolve ngsolve
```

In the output, you will see something like this:

```
[C 15:41:40.343 NotebookApp]

    To access the notebook, open this file in a browser:
        file:///home/jovyan/.local/share/jupyter/runtime/nbserver-7-open.html
    Or copy and paste one of these URLs:
        http://(7e5ca25e26ff or 127.0.0.1):8888/?token=f476cc82d45039420f4778347f1387071d9083a022bb14ee

```

Now, just visit 

```
http://127.0.0.1:8888/?token=$TOKEN
```

where `token` is everything to the right of the equal sign.

You can close the server either with `Ctrl-C` (twice) in your terminal, or with `docker stop ngsolve` in another shell prompt.
