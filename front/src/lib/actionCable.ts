export const loadCreateConsumer = async () => {
  const { createConsumer } = await import('@rails/actioncable')
  return createConsumer
}
