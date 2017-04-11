#!/bin/bash

date | awk '{print $5}' | cut -d/ -f1;

