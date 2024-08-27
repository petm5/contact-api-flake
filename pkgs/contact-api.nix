{ lib, fetchFromGitHub, rustPlatform, ... }:

rustPlatform.buildRustPackage rec {
  pname = "contact-api";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "petm5";
    repo = "contact-api";
    rev = "ee7a0e5aea5b221f711bb40e33ce77abb924c26a";
    hash = "sha256-a8jfUR9aN1ab4MGD9+t0xMyEsxSNyuWMzVx6xsoun30=";
  };

  cargoHash = "sha256-V5NdWv4z4WgQjRHQUtKUIupsFzsYU2BimtTa+6OgxGQ=";

  doCheck = false;

  meta = with lib; {
    description = "A backend HTTP server that receives messages and forwards them via e-mail";
    license = licenses.mit;
    maintainers = [];
  };
}
