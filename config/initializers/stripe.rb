if Rails.env.development?
  Stripe.api_key = "7ylqk5h5wO4BPImRpcWBhtAuZlUXE3wR"
  STRIPE_PUBLIC_KEY = "pk_fZ8VW3jnok03xmlJpZMmSV5ueCwU7"
else
  Stripe.api_key = "mkEm0gAOoAwNNTsWJ9KlWoAVq8tDPt88"
  STRIPE_PUBLIC_KEY = "pk_b4hWVN2gYtolH2aPGKVwxuO4Cd21Q"
end