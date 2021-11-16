resource "aws_key_pair" "shnam_key" {
  key_name = "shnam2-key"
#  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDqkYTj49iBV9MP2awZM4zrnbJdjrqparDodjvMrkqNm1TcQME1SVCYgqlLLVtO+2EWtBrguaRns1X8i4jW2vv+aW7vmmjAXphyS8wRNEo1+Z691LLLc21Ymd3w2BN817zL35pDu1GUrTjy46peh5hFpaPn1tA8isMuyhjW11AQfXwRk6VTTCf7N375/A0y+DjwtfZj/lTvCDWxSqgBPXSPOgRC/T4GGPRgA4i11M7v56DBtQzIyUDSgR3Nl+OXY8SxnJYGId8K5RsBlTaM/Czr+w/7sN0Ew9twKOaWMH7EGToQQIzbZuapWTnYWP4z1xCUcKdaJX+rLMwWvW7GuVAFwosfdQ9wEPUMEqG0zmFAitzPxI5ElPZvxpOtsvbT18k2A/ke1uajOwXJGcIzMOKZ9rIN/xoYjQeRAQ8cpiFDFR3pI9+LzsS72gXGzAONFJavV1waeDfNzBtC4JRti+ZCleXT0PdwIf8zby3AuYniU8CEdWQmaikSO9M6YAaG91U="
 public_key = file("../../.ssh/shnam-key.pub")
}