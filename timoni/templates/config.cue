package templates

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#Config: {
	metadata: metav1.#ObjectMeta
	apiVersion: "apiextensions.crossplane.io/v1"
	compositeTypeRef: {
		apiVersion: "devopstoolkitseries.com/v1alpha1"
		kind:       "CompositeCluster"
	}
	patchSets: [{
		name: "metadata"
		patches: [{
			fromFieldPath: "metadata.labels"
		}]
	}]
	versions: {
		traefik: *"23.0.1" | string
		crossplane: *"1.12.1" | string
	}
}

#Instance: {
	config: #Config
	objects: {
		civo: #Civo
		civoPort: #CivoPort
	}
}
