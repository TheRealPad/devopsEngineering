name: Bug Report
description: Report a reproducible bug
title: "[Bug]: "
labels: [bug]
body:
  - type: textarea
    attributes:
      label: What happened?
      description: Describe the bug in detail.
    validations:
      required: true
  - type: textarea
    attributes:
      label: Steps to reproduce
  - type: input
    attributes:
      label: Environment
      placeholder: "e.g., macOS 14, Node 20"
