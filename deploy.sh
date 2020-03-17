#!/bin/sh

rake generate
cp -f stylesheets/screen.css public/stylesheets/
rake deploy
