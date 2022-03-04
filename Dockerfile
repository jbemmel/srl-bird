ARG SR_LINUX_RELEASE
FROM srl/custombase:$SR_LINUX_RELEASE AS target-image

# Create a Python virtual environment, note --upgrade is broken
# RUN sudo python3 -m venv /opt/static-vxlan-agent/.venv --system-site-packages --without-pip
# ENV VIRTUAL_ENV=/opt/static-vxlan-agent/.venv
# ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# RUN sudo mkdir --mode=0755 -p /etc/opt/srlinux/appmgr/
# COPY --chown=srlinux:srlinux ./static-vxlan-agent.yml /etc/opt/srlinux/appmgr
# COPY ./src /opt/

# COPY bird.repo /etc/yum.repos.d/bird.repo

# Install BIRD Internet BGP Router
# RUN sudo curl ftp://bird.network.cz/pub/bird/redhat/RPM-GPG-KEY-network.cz -o /etc/pki/rpm-gpg/RPM-GPG-KEY-network.cz && \
#    sudo yum install -y readline-devel bird

# RUN sudo dnf makecache --refresh && sudo dnf install epel-release -y && sudo dnf -y install bird

RUN sudo yum install -y https://download-ib01.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/b/bird-2.0.9-1.el8.x86_64.rpm

# run pylint to catch any obvious errors
# RUN PYTHONPATH=$AGENT_PYTHONPATH pylint --load-plugins=pylint_protobuf -E /opt/static-vxlan-agent

# Using a build arg to set the release tag, set a default for running docker build manually
ARG SRL_BIRD_RELEASE="[custom build]"
ENV SRL_BIRD_RELEASE=$SRL_BIRD_RELEASE
