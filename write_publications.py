#!/usr/bin/env python

"""Utility to parse publications bibtex and INI file into groups for
moderncv inclusion
"""

from __future__ import print_function
import os
import argparse
try:
    import configparser
except ImportError:
    import ConfigParser as configparser
try:
    from collections import OrderedDict
except ImportError:
    from ordereddict import OrderedDict

# parse command line
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('config', help='config file with groups')
parser.add_argument('-o', '--output-dir', default='publications',
                    help="path to output directory for tex files, "
                         "default: %(default)s")
args = parser.parse_args()

# read configuration file
configdir = os.path.dirname(args.config)
config = configparser.ConfigParser(dict_type=OrderedDict)
n = config.read(args.config)
if not len(n):
    parser.error("Cannot read config file %r" % args.config)

# find categories and read bibtex files
bibfiles = []
for category in config.sections():
    try:
        bibtex = config.get(category, 'bibtex-file')
    except configparser.NoOptionError:
        bibtex = os.path.join(configdir, '%s.bib' % category)
    bibfiles.append(bibtex[:-4])
    keys = []
    with open(bibtex, 'rb') as f:
        for line in f:
            if line.startswith('@article'):
                keys.append(line.split('{', 1)[1].rstrip(',\n'))
    config.set(category, 'papers', ' '.join(keys))

# make output directory
if not os.path.isdir(args.output_dir):
    os.makedirs(args.output_dir)

# write publications setup
setuptexfile = os.path.join(args.output_dir, 'setup.tex')
setup = open(setuptexfile, 'w')
print(r"""%% setup publications
\bibliography{%s}
\nocite{*}
""" % ','.join(bibfiles), file=setup)
print("""% Publication categories
\def\makebibcategory#1#2#3{\DeclareBibliographyCategory{#1}\defbibheading{#1}{\subsection*{#2}\cvitem{}{#3}}}""", file=setup)

# loop over sections
pubtexfile = os.path.join(args.output_dir, 'publications.tex')
pubtex = open(pubtexfile, 'w')
print(r"\section{Publications}", file=pubtex)
for category in config.sections():
    # write setup
    print("\\makebibcategory{%s}{%s}{%s}"
          % (category, config.get(category, 'name'),
             config.get(category, 'description')), file=setup)
    # setup category tex file
    print('%% %s papers' % category, file=pubtex)
    print(r'\addtocategory{%s}{%%' % category, file=pubtex)
    for citekey in config.get(category, 'papers').split():
        print('    %s,%%' % citekey, file=pubtex)
    print('}}\n\\printbibliography[category={0},heading={0},category={0}]'
          .format(category), file=pubtex)

setup.close()
