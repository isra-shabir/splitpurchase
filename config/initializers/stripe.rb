Rails.configuration.stripe = {
  :publishable_key => "pk_test_3PP6j4HwXoUuWXwxEsEAAWYs",
  :secret_key      => "sk_test_rLTvBj0HzcAM6qz1CqimMB4r"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]