# GCP Binary Authorization Orb [![CircleCI Build Status](https://circleci.com/gh/CircleCI-Public/gcp-binary-authorization-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/CircleCI-Public/gcp-binary-authorization-orb) [![CircleCI Orb Version](https://img.shields.io/badge/endpoint.svg?url=https://badges.circleci.io/orb/circleci/gcp-binary-authorization)](https://circleci.com/orbs/registry/orb/circleci/gcp-binary-authorization) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/CircleCI-Public/gcp-binary-authorization-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/orbs)

Use Google's [Binary Authorization](https://cloud.google.com/binary-authorization) to sign/certify container images for deployment to Google Kubernetes Engine.

## Usage

_For full usage guidelines, see the [orb registry listing](http://circleci.com/orbs/registry/orb/circleci/gcp-binary-authorization)._

CircleCI's Binary Authorization orb can be used to configure and use Binary Authorization for any piece of software that is pushed to test/staging environments via Google's Container Registry, and deployed to production via Google Kubernetes Engine.

The orb can be used in a number of ways; however, in its simplest form, it provdes two jobs. One, `run-setup`, is designed to be added to a user's CircleCI configuration file, run successfully once, and then removed. The second, `create-attestation`, is designed to be permanently added to a `config.yml` file and run on every new commit as part of a pre-deployment workflow.


### [`run-setup`](https://circleci.com/orbs/registry/orb/circleci/gcp-binary-authorization#jobs-run-setup)

```yaml
version: 2.1

orbs:
  binary-authorization: circleci/gcp-binary-authorization@x.y.z

 workflows:
   your-workflow:
     jobs:
       - binary-authorization/run-setup
```

The `run-setup` job enables all required GCP APIs, can optionally create a GKE cluster, will create an attestor, optionally generate and store a PGP keypair, and optionally create and store a Binary Authorization policy YAML file.

To use `run-setup`, at least one existing Google project is required; if using a [multi-project Binary Authorization setup](https://cloud.google.com/binary-authorization/docs/multi-project-setup-cli), three separate Google projects (deployer, attestor, attestation) are required.

### [`create-attestation`](https://circleci.com/orbs/registry/orb/circleci/gcp-binary-authorization#jobs-create-attestation)

```yaml
version: 2.1

orbs:
  binary-authorization: circleci/gcp-binary-authorization@x.y.z

 workflows:
   your-workflow:
     jobs:
       - binary-authorization/create-attestation
```

The `create-attestation` job will sign/authorize a specific tag of a container stored in a Google container registry for deployment to GKE, provided whatever conditions specified via a [Binary Authorizatiion policy YAML file](https://cloud.google.com/binary-authorization/docs/policy-yaml-reference) have been met. If these conditions are _not_ met, any attempted deployments to GKE will be blocked.

`create-attestation` can also run all required setup steps, by passing the `run-setup: true` parameter. After successfully running these steps once, the parameter should be removed.

### Documentation

See the following links for more information about Google's Binary Authorization:

- https://cloud.google.com/binary-authorization
- https://cloud.google.com/binary-authorization/docs
- https://cloud.google.com/binary-authorization/docs/overview
- https://cloud.google.com/binary-authorization/docs/key-concepts
- https://cloud.google.com/binary-authorization/docs/how-to

See the following links for more information about using CircleCI orbs:

- https://circleci.com/orbs
- https://circleci.com/docs/2.0/using-orbs
- https://circleci.com/docs/2.0/reusing-config
- https://circleci.com/docs/2.0/orbs-faq

## Contributing

We welcome [issues](https://github.com/CircleCI-Public/gcp-binary-authorization-orb/issues) to and [pull requests](https://github.com/CircleCI-Public/gcp-binary-authorization-orb/pulls) against this repository!

For further questions/comments about this or other orbs, visit [CircleCI's orbs discussion forum](https://discuss.circleci.com/c/orbs).
