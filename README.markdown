# Hoarder

_For those who can't let go..._

Hoarder is a utility for pushing your files to cloud storage. Just specify the absolute path of a directory of files you want to store and Hoarder will push all of its contents to the cloud. Hoarder will outright replace any files with the same name in your cloud storage container (bucket?).

## Installation

    gem install hoarder

## Usage

Create a hoarder.yml file in the directory containing the files you want to push. Hoarder uses the gem [Fog](http://fog.io) to connect to cloud providers. Support is only provided for Rackspace Cloud Files (for now). The available hoarder.yml options are:

    rackspace_username: # Your Rackspace user name
    rackspace_api_key: # Your Rackspace api key
    container: # The name of the Cloud Files container to use (does not have to exist)
    public: # True or False depending on if you want the container to be CDN enabled

The rackspace_username and rackspace_api_key options come directly from [Fog](http://fog.io).

Then from your command line simply run:

    hoarder "/absolute/path/to/your/files"

## To Do

* Add support for Amazon S3
* Make uploading a little smarter
* More specs