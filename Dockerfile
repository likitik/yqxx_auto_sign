FROM node:14

LABEL "com.github.actions.name"="Automatically Sign for yqxx Everyday"
LABEL "com.github.actions.description"="A GitHub Action / Docker image for auto sign. Use chrome headless."
LABEL "com.github.actions.icon"="thumbs-up"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/tyde7/everyday_yqxx_sign"
LABEL "homepage"="https://github.com/tyde7/everyday_yqxx_sign"
LABEL "maintainer"="tyde7"

RUN  apt-get update \
     # See https://crbug.com/795759
     && apt-get install -yq libgconf-2-4 \
     # Install latest chrome dev package, which installs the necessary libs to
     # make the bundled version of Chromium that Puppeteer installs work.
     && apt-get install -y wget --no-install-recommends \
     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
     && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
     && apt-get update \
     && apt-get install -y google-chrome-stable --no-install-recommends \
     && rm -rf /var/lib/apt/lists/*

# When installing Puppeteer through npm, instruct it to not download Chromium.
# Puppeteer will need to be launched with:
#   browser.launch({ executablePath: 'google-chrome-unstable' })
# This is done by default in @ianwalter/bff.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true