FROM ubuntu:latest

WORKDIR /home/app

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

RUN apt-get update
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository universe
RUN add-apt-repository ppa:ngsolve/nightly -y
RUN apt-get install ngsolve -y
RUN apt-get install npm nodejs -y
        
RUN apt-get install vim emacs -y
RUN apt-get install -y cmake git python3-pip
RUN pip3 install --no-cache-dir notebook==5.*
RUN pip3 install --no-cache-dir jupyterlab
RUN pip3 install --no-cache-dir numpy scipy matplotlib
RUN pip3 install --no-cache-dir ipywidgets
RUN pip3 install --no-cache-dir psutil pytest
                    
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

RUN pip3 install --user webgui_jupyter_widgets
RUN jupyter nbextension install --user --py webgui_jupyter_widgets
RUN jupyter nbextension enable --user --py webgui_jupyter_widgets
        
USER root
#RUN jupyter labextension install --clean /usr/lib/python3/dist-packages/ngsolve/labextension
RUN chown -R ${NB_UID} ${HOME}

ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]
USER ${NB_USER}

WORKDIR /home/${NB_USER}
RUN python3 -c "import ngsolve"   


CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root" ]
