let
  pkgs = import <nixpkgs> { };
in
with pkgs;
stdenv.mkDerivation {
  name = "clang-shell";
  buildInputs = with pkgs; [ llvmPackages.clangUseLLVM cmake zlib opencv onnxruntime python ];
  shellHook = ''
    export OPENCV_PATH=${pkgs.opencv}/
    export ORT_PATH=${pkgs.onnxruntime}/
    export CC=clang
    export CXX=clang++
    export LLVM=1
    cd FastDeploy/build
  '';
}
