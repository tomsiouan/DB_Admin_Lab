FROM postgres:17

RUN apt-get update && apt-get install -y locales \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i -e 's/# fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && locale-gen

ENV LANG=fr_FR.UTF-8
ENV LC_ALL=fr_FR.UTF-8
