FROM abradle/rdkitserver:latest
MAINTAINER Anthony Bradley
RUN apt-get install -y autodock-vina
RUN wget http://mgltools.scripps.edu/downloads/downloads/tars/releases/REL1.5.6/mgltools_x86_64Linux2_1.5.6.tar.gz && tar -xzvf mgltools_x86_64Linux2_1.5.6.tar.gz &&cd mgltools_x86_64Linux2_1.5.6 && ./install.sh
RUN echo "alias pythonsh='/mgltools_x86_64Linux2_1.5.6/bin/pythonsh'" >> /root/.bashrc
RUN mkdir /DockingRuns && mkdir /DockingLibs && mkdir /DockingSetup
# Now add the docking envs
RUN cd /MYSITE/src/testproject && python manage.py syncdb --noinput 
ADD 18.sdf /18.sdf
ADD add_vina.py /MYSITE/src/testproject/add_vina.py
ADD add_vina.bash /add_vina.bash
RUN /bin/bash /add_vina.bash
ADD run_gunicorn.bash /run_gunicorn.bash
CMD cd /MYSITE && bash /set_nginx.bash && service nginx restart && bash /run_gunicorn.bash
