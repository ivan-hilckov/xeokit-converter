# ----------------------------------------------------------------------------
# xeokit-converter
# ----------------------------------------------------------------------------
FROM mcr.microsoft.com/dotnet/core/runtime:3.1-focal as xeokit-converter

RUN apt-get -qq update && apt-get -qq install -y \
  wget \
  unzip \
  git \
  python3.8 \
  curl \
  && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
  && apt-get install nodejs -y \
  && apt autoremove -qq  -y \
  && rm -r /var/lib/apt/lists/* \
  && npm i -g --silent npm@8.19.2

# ----------------------------------------------------------------------------
# Converting tools
# ----------------------------------------------------------------------------
# Install IfcOpenShell-python version 0.7.0, python 3.8
RUN wget --quiet https://s3.amazonaws.com/ifcopenshell-builds/ifcopenshell-python-38-v0.7.0-e508fb4-linux64.zip \
  && unzip -q ifcopenshell-python-38-v0.7.0-e508fb4-linux64.zip -d /usr/local/lib/python3.8/dist-packages \
  && rm -rf ifcopenshell-python-38-v0.7.0-e508fb4-linux64.zip

# Install IfcConvert version 0.7.0
RUN wget --quiet https://s3.amazonaws.com/ifcopenshell-builds/IfcConvert-v0.7.0-e44e03f-linux64.zip \
  && unzip -q IfcConvert-v0.7.0-e44e03f-linux64.zip -d /usr/lib/IfcConvert \
  && ln -s /usr/lib/IfcConvert/IfcConvert /usr/local/bin/IfcConvert \
  && rm -rf IfcConvert-v0.7.0-e44e03f-linux64.zip

# Install xeokit-metadata version 1.0.0 
RUN wget --quiet https://github.com/bimspot/xeokit-metadata/releases/download/1.0.1/xeokit-metadata-linux-x64.tar.gz \
  && tar -zxvf xeokit-metadata-linux-x64.tar.gz \
  && chmod +x xeokit-metadata-linux-x64/xeokit-metadata \
  && cp -r xeokit-metadata-linux-x64/ /usr/lib/xeokit-metadata \
  && ln -s /usr/lib/xeokit-metadata/xeokit-metadata /usr/local/bin/xeokit-metadata \
  && rm -rf xeokit-metadata-linux-x64.tar.gz

# Install xeokit-gltf-to-xkt latest version
RUN npm install -g --silent @xeokit/xeokit-convert@1.1.4 

