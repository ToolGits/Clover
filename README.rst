.. raw:: html

   <h1 align="center">Clover</h1>

   <p align="center">
     <img src=".github/images/clover-logo.png" alt="Clover Logo" width="400">
   </p>

   <p align="center">
     <strong>Reviving OpenCL. Reconnecting legacy GPUs.</strong>
   </p>

A revived and modernized Gallium3D OpenCL implementation, focused on
legacy GPU support and modern LLVM/Clang compatibility.

.. image:: https://img.shields.io/badge/version-0.0.1-blue?style=for-the-badge
   :target: https://github.com/ToolGits/Clover/releases
   :alt: Version

.. image:: https://img.shields.io/badge/compute-OpenCL-green?style=for-the-badge
   :target: https://www.khronos.org/opencl/
   :alt: OpenCL

.. image:: https://img.shields.io/badge/graphics-Gallium3D-orange?style=for-the-badge
   :target: https://docs.mesa3d.org/
   :alt: Gallium3D

.. image:: https://img.shields.io/badge/build-Meson-red?style=for-the-badge
   :target: https://mesonbuild.com/
   :alt: Meson

.. image:: https://img.shields.io/badge/organization-ToolGits-black?style=for-the-badge
   :target: https://github.com/ToolGits
   :alt: ToolGits

----

.. note::

   **Clover 0.0.1** is an early revived release focused on modernization
   and initial hardware testing.

Overview
--------

Clover is an open-source OpenCL implementation built on top of Gallium3D.

Originally developed as part of Mesa, Clover is being revived as an
independent project under the **ToolGits** organization.

The project focuses on modernizing the original implementation,
maintaining compatibility with newer LLVM and Clang versions, and
preserving OpenCL support for legacy GPUs.

Source
------

The official Clover repository is hosted on GitHub:

`github.com/ToolGits/Clover <https://github.com/ToolGits/Clover>`_

Clover is independently maintained and based on the Mesa 25.1.9 codebase.

Build & install
---------------

Clover uses the Mesa build system and Meson.

Build configuration depends on the target platform, GPU driver,
LLVM version and enabled Mesa components.

For more information, see the
`Meson documentation <https://mesonbuild.com/>`_.

Hardware and testing
--------------------

Initial development and testing focus on legacy AMD GPUs.

**Test environment:**

* GPU: AMD Radeon HD 7290
* Architecture: AMD R600 / TeraScale 2
* Mesa base: 25.1.9
* LLVM / Clang: 23.1.4

An OpenCL kernel has successfully compiled and executed on the
Radeon HD 7290.

This is an initial functional test, not a complete OpenCL
conformance certification.

Support
-------

For questions, technical discussions and project support, visit
the `Clover GitHub repository
<https://github.com/ToolGits/Clover>`_.

Bug reports
-----------

If you encounter a problem, please report it through
`GitHub Issues <https://github.com/ToolGits/Clover/issues>`_.

Include relevant system information, GPU details, LLVM/Clang versions
and build logs whenever possible.

Contributing
------------

Contributions are welcome!

Clover is independently maintained under the **ToolGits** organization.
Development, patches and discussions take place through GitHub.

See the repository for current development activity and contribution
opportunities.

Credits & license
-----------------

Clover originated in the Mesa project and continues development based
on the Mesa 25.1.9 codebase.

Original authorship, copyright notices and applicable licenses
remain respected.

Clover retains the applicable licenses of its original source files.
See individual source files and repository license information for details.

----

**Clover** — A ToolGits project.

`ToolGits <https://github.com/ToolGits>`_