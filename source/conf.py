import os

# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'AI Neuron (AIN) UVM Project'
copyright = '2026, Vladimir Armstrong'
author = 'Vladimir Armstrong'
# The short X.Y version.
version = '1.0'
# The full version, including alpha/beta/rc tags.
release = '1.0.0'
today_fmt = '%B %d, %Y'
html_show_copyright = False

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [
    'sphinx_rtd_theme',
    'sphinx_rtd_size',
    'sphinx_design',
    'sphinxcontrib.plantuml',
]

sphinx_rtd_size_width = "100%"

templates_path = ['_templates']
exclude_patterns = []

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']

local_plantuml_path = os.path.join(os.path.dirname(__file__), "utils", "plantuml-1.2025.10.jar")
local_config_path = os.path.join(os.path.dirname(__file__), "utils", "plantuml_config.cfg")
plantuml = f"java -jar {local_plantuml_path} -config {local_config_path}"
plantuml_output_format = 'svg'
