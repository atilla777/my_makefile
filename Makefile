elasticsearch:
	docker run --rm --name elastic \
	 	--net elastic \
	 	-p 9200:9200 \
	 	-e "xpack.security.enabled=false" \
	 	-e "discovery.type=single-node" \
	 	-v ~/docker_data/elastic:/usr/share/elasticsearch/data docker.elastic.co/elasticsearch/elasticsearch:8.0.0-rc2-amd64
kibana:
	docker run --rm --name kibana \
		--net elastic \
		-p 5601:5601 \
		-e "ELASTICSEARCH_HOSTS=http://elastic:9200" \
		docker.elastic.co/kibana/kibana:8.0.0

nats:
	docker run --rm --name nats-main \
		-p 4222:4222 \
		-p 6222:6222 \
		-p 8222:8222 \
		nats:2.7.3-alpine3.15 \
		-js

otel_collector:
	docker run --rm --name otel_collector \
		-v "${PWD}/otel-config.yaml":/otel-config.yaml \
		-p 55681:55681 \
		otel/opentelemetry-collector:0.46.0-amd64
		--config otel-config.yaml;

jaeger:
	docker run --rm --name jaeger \
		-p 14250:14250 \
		-p 16686:16686 \
		jaegertracing/all-in-one:1.32
