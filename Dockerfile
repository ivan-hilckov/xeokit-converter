# ----------------------------------------------------------------------------
# xeokit-converter
# ----------------------------------------------------------------------------
FROM mcr.microsoft.com/dotnet/core/runtime:3.1-focal as xeokit-converter

RUN \
  apt-get -qq update \
  && apt-get -qq install -y \
      wget \
      unzip \
      git \
      python3.8 \
      curl \
  && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
  && apt-get install nodejs -y \
  && npm i -g --silent npm@8.19.2 \
  && npm install -g --silent @xeokit/xeokit-convert@1.1.4 commander@9.4.1

ADD converter-stuff /tmp/converter-stuff
ADD xeokit-convert-ifc /usr/local/bin/

RUN \
  cd tmp \
  && unzip -q converter-stuff/ifcopenshell-python-38-v0.7.0-e508fb4-linux64.zip -d /usr/local/lib/python3.8/dist-packages \
  && unzip -q converter-stuff/IfcConvert-v0.7.0-e44e03f-linux64.zip -d /usr/lib/IfcConvert \
  && ln -s /usr/lib/IfcConvert/IfcConvert /usr/local/bin/IfcConvert \
  && tar -zxvf converter-stuff/xeokit-metadata-linux-x64.tar.gz \
  && chmod +x xeokit-metadata-linux-x64/xeokit-metadata \
  && mv xeokit-metadata-linux-x64 /usr/lib/xeokit-metadata/ \
  && ln -s /usr/lib/xeokit-metadata/xeokit-metadata /usr/local/bin/xeokit-metadata \
  && rm -rf xeokit-metadata-linux-x64.tar.gz \
  && chmod 0755 /usr/local/bin/xeokit-convert-ifc \
  && apt autoremove -qq -y \
  && rm -fr /var/lib/apt/lists/* tmp/* \
