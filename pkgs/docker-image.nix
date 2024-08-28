{ pkgs, dockerTools, contact-api, ... }:

dockerTools.buildLayeredImage {

  name = "contact-api";
  tag = "latest";

  contents = [ contact-api pkgs.cacert ];

  config = {
    Cmd = [ "${contact-api}/bin/contact-api" ];
    ExposedPorts = {
      "8080/tcp" = { };
    };
  };

}
