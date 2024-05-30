import colorcet
import matplotlib as mpl

from ._draw import draw_arrows, draw_earth, draw_multicolored_line
from ._format import add_colorbar, add_text, format_datetime_axis
from ._setup import _setup_matplotlib

_setup_matplotlib()

# Aliases
mplc = mpl.colors
plt = mpl.pyplot
