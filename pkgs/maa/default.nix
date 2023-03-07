{ lib
, stdenv
, fetchFromGitHub
, pkgs
, ...
}:

stdenv.mkDerivation rec {
  # 指定包名和版本
  pname = "MaaAssistantArknights";
  version = "4.11.0";

  # 从 GitHub 下载源代码
  src = fetchFromGitHub ({
    owner = "MaaAssistantArknights";
    repo = "MaaAssistantArknights";
    # 对应的 commit 或者 tag，注意 fetchFromGitHub 不能跟随 branch！
    rev = "d1d82e27e369a93d148a5fec6f504d7b599fd10e";
    # 下载 git submodules，绝大部分软件包没有这个
    fetchSubmodules = false;
    # 这里的 SHA256 校验码不会算怎么办？先注释掉，然后构建这个软件包，Nix 会报错，并提示你正确的校验码
    sha256 = "sha256-e8aV7ig8KdSJMI0yHg0bJhoJseyAHmfHGdyDpy8eT3E=";
  });

  # 并行编译，大幅加快打包速度，默认是启用的。对于极少数并行编译会失败的软件包，才需要禁用。
  enableParallelBuilding = true;
  # 如果基于 CMake 的软件包在打包时出现了奇怪的错误，可以尝试启用此选项
  # 此选项禁用了对 CMake 软件包的一些自动修正
  dontFixCmake = true;

  # 将 CMake 加入编译环境，用来生成 Makefile
  nativeBuildInputs = with pkgs; [ cmake gcc12 zlib opencv ];

  # 传给 CMake 的配置参数，控制 liboqs 的功能
  cmakeFlags = [
    "-DINSTALL_THIRD_LIBS=ON"
    "-DINSTALL_RESOURCE=ON"
    "-DINSTALL_PYTHON=ON"
  ];

  # stdenv.mkDerivation 自动帮你完成其余的步骤
}
