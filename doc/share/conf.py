# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

from pathlib import Path
import time
import toml


ROOT = Path(__file__).parents[2]
with open(ROOT / 'alire.toml') as f:
    alr_config = toml.load(f)


# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'Labs Solar System'

def get_copyright():
    y_start = '2023'
    y = time.strftime('%Y')
    return  (f'{y_start}-{y}' if y != y_start else y_start) + ', AdaCore'

copyright = get_copyright()
author = ",".join(alr_config['authors'])
version = alr_config['version']

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = ['sphinx_rtd_theme']

templates_path = ['_templates']
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'sphinx_rtd_theme'

if Path('adacore_transparent.png').is_file():
    # split html and pdf logos to avoid 'same name' error in sphinx <5.2+
    html_logo = 'adacore_transparent.png'
    latex_logo = 'adacore_transparent.png'

if Path('favicon.ico').is_file():
    html_favicon = 'favicon.ico'
