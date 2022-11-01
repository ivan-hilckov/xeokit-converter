# xeokit-converter

The image contains all tools needed for the [conversion of IFC files][1]
to the `xkt` format for the xeokit viewer.

- IfcConvert (IfcOpenShell)
- xeokit-metadata
- @xeokit/xeokit-convert

## Usage

```
$ docker pull [...]
```

```bash

echo "Converting IFC to GLB"

./IfcConvert --use-element-guids model.ifc model.glb
```

```bash
echo "Converting IFC to GLB with fixing missing IfcSpaces"

./IfcConvert --use-element-guids model.ifc model.glb --exclude=entities IfcOpeningElement
```

```bash
echo "Extract Metadata JSON from IFC"

xeokit-metadata model.ifc model.json
```

```bash
echo "Convert Binary glTF and Metadata to XKT"

@xeokit/xeokit-convert -s model.glb -m model.json -o model.xkt -l
```

## Environment

The `IfcConvert` library is available through [`bimspot/ifcopenshell`][2].
The xeokit-converter image is based on the [bionic dotnet runtime][3].

## Distribution

The image is build locally and pushed to [Docker hub][5] with your own credentials.
Semver applies.

```
~ docker build -t bimspot/xeokit-converter:1.3.x .
~ docker push bimspot/xeokit-converter:1.3.x
```

[1]: https://www.notion.so/Converting-IFC-Models-to-XKT-using-Open-Source-Tools-A-Simpler-Pipeline-02d45ba457eb4f808f63bcacb71a4fb3
[2]: https://cloud.docker.com/u/bimspot/repository/docker/bimspot/ifcopenshell
[3]: mcr.microsoft.com/dotnet/core/runtime:2.2-bionic
[4]: https://cloud.docker.com/u/bimspot/repository/docker/bimspot/xeokit-converter
[5]: https://hub.docker.com/r/bimspot/xeokit-converter
