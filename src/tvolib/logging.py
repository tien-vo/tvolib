__all__ = ["setup_logger"]

import logging
import sys
from os import environ


def setup_logger():
    logging.basicConfig(
        format=r"%(asctime)s [%(levelname)s]: %(message)s",
        level=logging.INFO if environ.get("DEBUG") is None else logging.DEBUG,
        handlers=[logging.StreamHandler(sys.stdout)],
    )
    logging.captureWarnings(True)
