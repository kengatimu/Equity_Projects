1. How to convert java object to XMl and Json

private void logOmniRequestDto(OmniRequestDto req) {
        try {
            ObjectMapper jsonMapper = new ObjectMapper();
            XmlMapper xmlMapper = new XmlMapper();

            String json = jsonMapper.writerWithDefaultPrettyPrinter().writeValueAsString(req);
            String xml = xmlMapper.writerWithDefaultPrettyPrinter().writeValueAsString(req);

//            log.info("OmniRequestDto as JSON:\n{}", json);
            log.info("OmniRequestDto as JSON:\n{}", gson.toJson(req));
            log.info("OmniRequestDto as XML:\n{}", xml);
        } catch (Exception e) {
            log.error("Error logging OmniRequestDto", e);
        }
    }