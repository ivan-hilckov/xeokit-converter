# xeokit-converter

The image contains all tools needed for the [conversion of IFC files][1]
to the `xkt` format for the xeokit viewer.

- IfcConvert (IfcOpenShell)
- @xeokit/xeokit-metadata
- @xeokit/xeokit-convert

## Pipeline

```bash
IFC => GLB  |
            | => XKT
IFC => JSON |
```

![pipeline](https://raw.githubusercontent.com/ivan-hilckov/xeokit-converter/master/pipeline.png)

## Usage

```bash
docker build -t xeokit-converter .
docker run -it -v ~/data:/data xeokit-converter sh
```

```bash

echo "Converting IFC to GLB"

IfcConvert --use-element-guids /data/model.ifc /data/model.glb
```

```bash
echo "Converting IFC to GLB with fixing missing IfcSpaces"

IfcConvert --use-element-guids /data/model.ifc /data/model-v2.glb --exclude=entities IfcOpeningElement
```

```bash
echo "Extract Metadata JSON from IFC"

xeokit-metadata /data/model.ifc /data/model.json
```

```bash
echo "Convert Binary glTF and Metadata to XKT"

xeokit-convert -s /data/model.glb -m /data/model.json -o /data/model.xkt -l
```

```bash
IfcConvert --use-element-guids /data/model.ifc /data/model.glb
xeokit-metadata /data/model.ifc /data/model.json
xeokit-convert -s /data/model.glb -m /data/model.json -o /data/model.xkt -l
```

## Environment

The `IfcConvert` library is available through [`bimspot/ifcopenshell`][2].
The xeokit-converter image is based on the [bionic dotnet runtime][3].

[1]: https://www.notion.so/Converting-IFC-Models-to-XKT-using-Open-Source-Tools-A-Simpler-Pipeline-02d45ba457eb4f808f63bcacb71a4fb3
[2]: https://cloud.docker.com/u/bimspot/repository/docker/bimspot/ifcopenshell
[3]: mcr.microsoft.com/dotnet/core/runtime:2.2-bionic
