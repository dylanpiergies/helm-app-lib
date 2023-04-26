# app-lib

A Helm library chart containing named templates to simplify the development of application charts. This library is not
intended to support every available feature in Kubernetes. Rather, it is intended to support the most common use cases
by providing templates for the resources most commonly used together to form a single application.

This library is designed to enable application chart developers to minimise duplication and maximise reuse of template.
It's intended to be as unopinionated as possible. If you need more opinionated partial templates, you fork this chart or
use it in conjunction with your own standardised templates, perhaps from another library chart.

---

## Quick Start

Let's take a look at the simplest possible use case. To use the library, add it as a dependency to your application
chart:

**Chart.yaml**
```yaml
dependencies:
- name: app-lib
  version: 0.4.0
  repository: https://dylanpiergies.github.io/helm-charts
```

Then include the main template:

**templates/application.yaml**
```gotemplate
{{- include "app-lib.main" . -}}
```

and configure a minimal set of values:

**values.yaml**
```yaml
image: nginx
```

That's it! This chart will now render to a manifest consisting of a Deployment with a Pod template defining a single
container, running the `nginx:latest` image from Docker hub.

Just for cleanliness, if our application chart name differs from that of the container image, we can override the
container name:

**values.yaml**
```yaml
containerNameOverride: nginx
```

So now we have Nginx web server running in a container. Clearly, in order to be useful, the server needs to be able to
receive HTTP requests. So let's add a container port:

**values.yaml**
```yaml
containerPorts:
- name: http
  containerPort: 80
  protocol: TCP
```

and a Service:

**values.yaml**
```yaml
service:
  type: ClusterIP
  ports:
  - port: 80
    targetPort: http
    protocol: TCP
    name: http
```

Now we have everything we need to communicate with the web server from other applications within the cluster. Let's
finish off by adding an Ingress to accept traffic for outside the cluster:

**values.yaml**
```yaml
ingress:
  enabled: true
  servicePort: http
  hosts:
  - host: nginx.example.com
    paths:
    - path: /
      pathType: Prefix
```

Those already familiar with Kubernetes manifests and/or Helm chart development should be able to see immediately how
little code we've had to write to define a complete application manifest compared to the amount of code we would have
written had we defined a complete template for each Kubernetes resource.
