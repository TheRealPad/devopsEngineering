name: Feature Request
description: Suggest a new feature or enhancement
title: "[Feature]: "
labels: [enhancement]
assignees: []

body:
  - type: markdown
    attributes:
      value: |
        💡 **Thank you for suggesting a feature!**  
        Please fill out the details below to help us understand your request.

  - type: input
    id: summary
    attributes:
      label: Feature Summary
      description: Briefly describe the feature you would like to see.
      placeholder: Add dark mode support, export to PDF, etc.
    validations:
      required: true

  - type: textarea
    id: motivation
    attributes:
      label: Why is this feature important?
      description: What problem does it solve? Why is it valuable?
    validations:
      required: true

  - type: textarea
    id: solution
    attributes:
      label: Proposed Solution
      description: If you have ideas for how this could be implemented, describe them here.
    validations:
      required: false

  - type: textarea
    id: alternatives
    attributes:
      label: Alternatives Considered
      description: Have you tried other workarounds or existing features?
    validations:
      required: false

  - type: checkboxes
    id: terms
    attributes:
      label: Code of Conduct
      options:
        - label: I agree to follow this project's [Code of Conduct](../CODE_OF_CONDUCT.md)
          required: true
