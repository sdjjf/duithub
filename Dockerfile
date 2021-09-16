# 指定ubutu为基础镜像
FROM ubuntu

# 设置镜像作者
MAINTAINER PomanTeng

# 更新源
RUN sed -i 's#http://archive.ubuntu.com/#http://mirrors.tuna.tsinghua.edu.cn/#' /etc/apt/sources.list;

# 进行系统更新
RUN apt-get update --fix-missing

# 安装sudo命令
RUN apt install -y sudo

# 安装声卡驱动
RUN sudo apt-get install -y alsa-base
RUN sudo apt-get install -y pulseaudio

# 创建Docker容器中,Java环境的存放目录
RUN mkdir /usr/local/java

# 解压jdk安装文件到Java环境的存放目录
ADD jdk-8u131-linux-x64.tar.gz /usr/local/java/

# 创建jdk目录的同步链接
RUN ln -s /usr/local/java/jdk1.8.0_131 /usr/local/java/jdk

# 设置Java环境变量
ENV JAVA_HOME=/usr/local/java/jdk
ENV CLASSPATH=.:${JAVA_HOME}/lib/tools.jar:${JAVA_HOME}/lib/dt.jar
ENV PATH=${JAVA_HOME}/bin:$PATH

# 设置Jar文件的相对路径
ADD Music01.jar /music.jar

# 运行Jar文件
ENTRYPOINT ["java","-jar","/music.jar"]
