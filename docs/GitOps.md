# GitOps

As one of the final steps of kubernetes bootstrapping, this playbook installs [flux v2](https://github.com/fluxcd/flux2) components and initial custom resources.

## Flux Custom Resources

The [setup-flux](../roles/setup-flux/) role contains tasks which utilize Kustomize v4 to install flux v2 components and CRDs. **We're deactivating image-reflector-controller and image-automation-controller deployments by setting replicas to zero**.

Along with flux v2 components, these custom resources are installed:

1. A [`GitRepository`](https://toolkit.fluxcd.io/components/source/gitrepositories/) CR pointing at https://github.com/codeformuenster/kubernetes-deployment
2. A [`Kustomization`](https://toolkit.fluxcd.io/components/kustomize/kustomization/) CR using (1) as `sourceRef`
3. A [`Secret`](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.20/#secret-v1-core) containing a GPG key for secret decryption using [SOPS](https://github.com/mozilla/sops) for (2)
4. A [`Provider`](https://toolkit.fluxcd.io/components/notification/provider/) CR for notifications to GitHub (`type: github`)
5. A [`Secret`](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.20/#secret-v1-core) containing credentials for (4)
6. An [`Alert`](https://toolkit.fluxcd.io/components/notification/alert/) CR referencing (2) as `eventSource` and (4) as `provider`

Once set up, flux will do its job to reconcile the contents of https://github.com/codeformuenster/kubernetes-deployment
