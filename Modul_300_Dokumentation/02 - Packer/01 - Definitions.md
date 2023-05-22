## Packer Block

The `packer {}` block contains Packer settings, including specifying a required Packer version.

In addition, you will find `required_plugins` block in the Packer block, which specifies all the plugin required by the template to build your image. Even though Packer is packaged into a single binary, it depends on plugins for much of its functionality. Some of these plugins, like the Docker Builder which you will to use, are built, maintained, and distributed by HashiCorp — but anyone can write and use plugins.
```hcl
packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source = "github.com/hashicorp/docker"
    }
  }
}
```

Each plugin block contains a version and `source` attribute. Packer will use these attributes to download the appropriate plugin(s).
-   The `source` attribute is only necessary when requiring a plugin outside the HashiCorp domain. You can find the full list of HashiCorp and community maintained builders plugins in the [Packer Builders](https://developer.hashicorp.com/packer/docs/builders) documentation page.
-   The version attribute is optional, but we recommend using it to constrain the plugin version so that Packer does not install a version of the plugin that does not work with your template. If you do not specify a plugin version, Packer will automatically download the most recent version during initialization.
## Source block

The `source` block configures a specific _builder_ plugin, which is then invoked by a `build` block. Source blocks use [builders](https://developer.hashicorp.com/packer/docs/builders) and [communicators](https://developer.hashicorp.com/packer/docs/communicators) to define what kind of virtualization to use, how to launch the image you want to provision, and how to connect to it. Builders and communicators are bundled together and configured side-by-side in a source block. A `source` can be reused across multiple builds, and you can use multiple `source`s in a single build. A builder plugin is a component of Packer that is responsible for creating a machine and turning that machine into an image.

A source block has two important labels: a _builder type_ and a _name_. These two labels together will allow us to uniquely reference sources later on when we define build runs.

In the example template, the builder type is `docker` and the name is `ubuntu`.

```hcl
source "docker" "ubuntu" {
  image       = "ubuntu:xenial"
  commit      = true
}
```

Each builder has its own unique set of configuration attributes. The Docker builder starts a Docker container, runs provisioners within this container, then exports the container for reuse or commits the image.

In the example template, the Docker builder configuration creates a new Docker image using `ubuntu:xenial` as the base image, then commits the container to an image.

## The Build Block

The `build` block defines what Packer should do with the Docker container after it launches.

In the example template, the build block references the Docker image defined by the source block above (`source.docker.ubuntu`).

```hcl
build {
  name    = "learn-packer"
  sources = [
    "source.docker.ubuntu"
  ]
}
```