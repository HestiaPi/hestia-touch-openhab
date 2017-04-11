#!/bin/bash

df | grep root  | awk '{print $5}'

