# Digitalocean: Kelas Docker

# HOWTO build docker images

## General imformation

Pre-requisites on your host machine:

- Install [Docker](https://docs.docker.com/install/)

#### From Windows host:

- Install [Virtualbox](https://www.virtualbox.org/manual/ch01.html)
- Install any X Server. For example [VcXsrv](https://sourceforge.net/projects/vcxsrv/)

#### From Mac host:

- Install [Virtualbox](https://www.virtualbox.org/manual/ch01.html)
- Install [XQuartz](https://www.xquartz.org)

#### From Linux host:

- No other requirements

## Build docker image

For Windows host, rename ```build.cmd.a``` and ```run.cmd.a``` to ```build.cmd``` and ```run.cmd``` respectivelly.

Special scrips ```build.sh``` (or ```build.cmd```) can be executed to automatically build all necessary images.

There are several build stages:

1. Build STF Ubuntu 18.04 image
2. Install Titan from Github
3. Install Eclipse and Titan Eclipse plugin into ~/frameworks/titan
4. Install asn1c into ~/frameworks/asn1c
5. Checkout STF569 sources from ETSI svn repository using default credentials
6. Build ASN.1 recoder library
7. Build certificate generation tool

## Import and build ITS project

### Run Docker image

#### From Windows host:

1. Authorize Docker container to interact with the XServer:
Go to the X Server installation directory and add the Docker container ip address to the file ```X0.hosts```:
```
localhost  
inet6:localhost  
192.168.99.100  
```

Execute ```run.cmd``` or launch a command line window and run the command

```docker run -it --net=host -e DISPLAY=192.168.99.1:0 stf569_its:latest```

NOTE: Modify the IP address in the command for the address of 'VirtualBox Hot-Only Network'.

#### From Linux host:

Execute ```run.sh``` or launch a command line window and run the command

```sh
docker run -it --net=host -e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix stf569_its:latest
```

### Import eclipse project

1. Whithin the docker container, on the linux command prompt type:

   ```eclipse -data ~/dev/Workspace```

   Eclipse IDE shall be shown on the hosts Screen.
   Possible problems:
   - eclipse not found: check the PATH environment variable. It shall contain $HOME/bin path. Otherwise add it:
     ```export PATH=$HOME/bin:$PATH```

2. Run "File -> Import" and import the ```~/dev/STF569_Its/STF569.tpd``` file.

   This can take a time, be patient.
   **Do not run build in eclipse**, we don't have enough time.

### Build the project

```cd ~/Workspace/STF569/bin```

```make```

Possible problems:
  - Error in AbstractSocket build: Build it explicitly:
     ```cd ~/Workspace/Abstract_Socket_CNL113384/bin_ssl && make```

### Execute tests
1. Launch eclipse: ```eclipse -data ~/dev/Workspace```
2. Select configuration from the /etc/folder:
 - AtsCAM/AtsCAM.cfg                     - CAM test suite.
 - AtsDENM/AtsDENM.cfg                   - DENM test suite.
 - AtsGenCert/AtsGenCert.cfg             - Certificate generator
 - AtsGeoNetworking/AtsGeoNetworking.cfg - GeoNetworking test suite
 - AtsIVIM/AtsIVIM.cfg
 - AtsMapemSpatem/AtsMapemSpatem.cfg
 - AtsRSUsSimulator/AtsRSUSimulator.cfg
 - AtsSecurity/AtsSecurity.cfg
 - AtsSremSsem/AtsSremSsem.cfg
3. Right-click on the configuration file and select **Run As -> TITAN Parallel launcher**
