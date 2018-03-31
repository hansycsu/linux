#!/bin/bash

wcd() {
  cd "$(tr '\\' '/' <<< "$1")"
}
