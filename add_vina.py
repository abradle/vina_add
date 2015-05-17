#!/usr/bin/env python
import os
import sys
from rdkit import Chem
# Set up the enivornment
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "testproject.settings")
from docking_runs.functions import *
# First add the library
in_mols = Chem.SDMolSupplier("/18.sdf")
register_lib(in_mols, lib_name="DEFAULT")
# Next add the docking library
register_env("VINA", "1aq1", name="DEFAULT", prot_name="CDK2", uniprot="P24941")
