{inputs, ...}: {
	additions = final: _prev: import ../pkgs final.pkgs;

	#file contains overlays for existing packages
	# https://nixos.wiki/wiki/Overlays
	modifications = final: prev: {
	};

	# allows unstable packages via pkgs.unstable
	unstable-packages = final: _prev: {
		unstable = import inputs.nixpkgs-unstable {
			system = final.system;
			config.allowUnfree = true;
		};
	};
}
